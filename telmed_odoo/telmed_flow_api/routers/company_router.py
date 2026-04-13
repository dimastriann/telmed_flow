from typing import Annotated, List
from fastapi import APIRouter, Depends, HTTPException, status
from odoo.api import Environment
from odoo.addons.fastapi.dependencies import odoo_env, paging
from odoo.addons.fastapi.schemas import Paging
from ..dependencies import get_current_partner
from ..schemas import CompanySchema, CompanyCreate, CompanyUpdate, CollectionResponse, BatchUpdateItem

router = APIRouter(prefix="/companies", tags=["Companies"], dependencies=[Depends(get_current_partner)])

@router.get("/", response_model=CollectionResponse[CompanySchema])
def get_companies(
    env: Annotated[Environment, Depends(odoo_env)],
    paging: Annotated[Paging, Depends(paging)]
):
    Company = env["res.company"]
    count = Company.search_count([])
    records = Company.search([], limit=paging.limit, offset=paging.offset)
    return CollectionResponse(
        count=count,
        items=[CompanySchema.model_validate(r) for r in records]
    )

@router.get("/{company_id}", response_model=CompanySchema)
def get_company(
    company_id: int,
    env: Annotated[Environment, Depends(odoo_env)]
):
    record = env["res.company"].browse(company_id)
    if not record.exists():
        raise HTTPException(status_code=404, detail="Company not found")
    return CompanySchema.model_validate(record)

@router.post("/", response_model=CompanySchema, status_code=status.HTTP_201_CREATED)
def create_company(
    data: CompanyCreate,
    env: Annotated[Environment, Depends(odoo_env)]
):
    vals = data.model_dump(exclude_unset=True)
    record = env["res.company"].create(vals)
    return CompanySchema.model_validate(record)

@router.put("/{company_id}", response_model=CompanySchema)
def update_company(
    company_id: int,
    data: CompanyUpdate,
    env: Annotated[Environment, Depends(odoo_env)]
):
    record = env["res.company"].browse(company_id)
    if not record.exists():
        raise HTTPException(status_code=404, detail="Company not found")
    vals = data.model_dump(exclude_unset=True)
    record.write(vals)
    return CompanySchema.model_validate(record)

@router.delete("/{company_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_company(
    company_id: int,
    env: Annotated[Environment, Depends(odoo_env)]
):
    record = env["res.company"].browse(company_id)
    if not record.exists():
        raise HTTPException(status_code=404, detail="Company not found")
    record.unlink()
    return None

@router.post("/batch", response_model=List[CompanySchema], status_code=status.HTTP_201_CREATED)
def create_companies_batch(
    data: List[CompanyCreate],
    env: Annotated[Environment, Depends(odoo_env)]
):
    Company = env["res.company"]
    vals_list = [d.model_dump(exclude_unset=True) for d in data]
    records = Company.create(vals_list)
    return [CompanySchema.model_validate(r) for r in records]

@router.put("/batch", response_model=List[CompanySchema])
def update_companies_batch(
    items: List[BatchUpdateItem[CompanyUpdate]],
    env: Annotated[Environment, Depends(odoo_env)]
):
    Company = env["res.company"]
    results = []
    for item in items:
        record = Company.browse(item.id)
        if record.exists():
            vals = item.data.model_dump(exclude_unset=True)
            record.write(vals)
            results.append(record)
    return [CompanySchema.model_validate(r) for r in results]

@router.delete("/batch", status_code=status.HTTP_204_NO_CONTENT)
def delete_companies_batch(
    ids: List[int],
    env: Annotated[Environment, Depends(odoo_env)]
):
    records = env["res.company"].browse(ids)
    if records:
        records.unlink()
    return None
