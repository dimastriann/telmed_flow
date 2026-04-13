from typing import Annotated, List
from fastapi import APIRouter, Depends, HTTPException, status
from odoo.api import Environment
from odoo.addons.fastapi.dependencies import odoo_env, paging
from odoo.addons.fastapi.schemas import Paging
from ..dependencies import get_current_partner
from ..schemas import PartnerSchema, PartnerCreate, PartnerUpdate, CollectionResponse, BatchUpdateItem

router = APIRouter(prefix="/contacts", tags=["Contacts"], dependencies=[Depends(get_current_partner)])

@router.get("/", response_model=CollectionResponse[PartnerSchema])
def get_contacts(
    env: Annotated[Environment, Depends(odoo_env)],
    paging: Annotated[Paging, Depends(paging)]
):
    Partner = env["res.partner"]
    domain = [("is_company", "=", False)]
    count = Partner.search_count(domain)
    records = Partner.search(domain, limit=paging.limit, offset=paging.offset)
    return CollectionResponse(
        count=count,
        items=[PartnerSchema.model_validate(r) for r in records]
    )

@router.get("/{partner_id}", response_model=PartnerSchema)
def get_contact(
    partner_id: int,
    env: Annotated[Environment, Depends(odoo_env)]
):
    record = env["res.partner"].browse(partner_id)
    if not record.exists() or record.is_company:
        raise HTTPException(status_code=404, detail="Contact not found")
    return PartnerSchema.model_validate(record)

@router.post("/", response_model=PartnerSchema, status_code=status.HTTP_201_CREATED)
def create_contact(
    data: PartnerCreate,
    env: Annotated[Environment, Depends(odoo_env)]
):
    vals = data.model_dump(exclude_unset=True)
    vals["is_company"] = False
    record = env["res.partner"].create(vals)
    return PartnerSchema.model_validate(record)

@router.put("/{partner_id}", response_model=PartnerSchema)
def update_contact(
    partner_id: int,
    data: PartnerUpdate,
    env: Annotated[Environment, Depends(odoo_env)]
):
    record = env["res.partner"].browse(partner_id)
    if not record.exists() or record.is_company:
        raise HTTPException(status_code=404, detail="Contact not found")
    vals = data.model_dump(exclude_unset=True)
    record.write(vals)
    return PartnerSchema.model_validate(record)

@router.delete("/{partner_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_contact(
    partner_id: int,
    env: Annotated[Environment, Depends(odoo_env)]
):
    record = env["res.partner"].browse(partner_id)
    if not record.exists() or record.is_company:
        raise HTTPException(status_code=404, detail="Contact not found")
    record.unlink()
    return None

@router.post("/batch", response_model=List[PartnerSchema], status_code=status.HTTP_201_CREATED)
def create_contacts_batch(
    data: List[PartnerCreate],
    env: Annotated[Environment, Depends(odoo_env)]
):
    Partner = env["res.partner"]
    vals_list = []
    for d in data:
        vals = d.model_dump(exclude_unset=True)
        vals["is_company"] = False
        vals_list.append(vals)
    records = Partner.create(vals_list)
    return [PartnerSchema.model_validate(r) for r in records]

@router.put("/batch", response_model=List[PartnerSchema])
def update_contacts_batch(
    items: List[BatchUpdateItem[PartnerUpdate]],
    env: Annotated[Environment, Depends(odoo_env)]
):
    Partner = env["res.partner"]
    results = []
    for item in items:
        record = Partner.browse(item.id)
        if record.exists() and not record.is_company:
            vals = item.data.model_dump(exclude_unset=True)
            record.write(vals)
            results.append(record)
    return [PartnerSchema.model_validate(r) for r in results]

@router.delete("/batch", status_code=status.HTTP_204_NO_CONTENT)
def delete_contacts_batch(
    ids: List[int],
    env: Annotated[Environment, Depends(odoo_env)]
):
    records = env["res.partner"].browse(ids).filtered(lambda r: not r.is_company)
    if records:
        records.unlink()
    return None
