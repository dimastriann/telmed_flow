from typing import Annotated
from fastapi import APIRouter, Depends, HTTPException, status
from odoo.api import Environment
from odoo.addons.fastapi.dependencies import odoo_env, paging
from odoo.addons.fastapi.schemas import Paging
from ..dependencies import get_current_partner
from ..schemas import UserSchema, UserCreate, UserUpdate, CollectionResponse

router = APIRouter(prefix="/users", tags=["Users"], dependencies=[Depends(get_current_partner)])

@router.get("/", response_model=CollectionResponse[UserSchema])
def get_users(
    env: Annotated[Environment, Depends(odoo_env)],
    paging: Annotated[Paging, Depends(paging)]
):
    User = env["res.users"]
    count = User.search_count([])
    records = User.search([], limit=paging.limit, offset=paging.offset)
    return CollectionResponse(
        count=count,
        items=[UserSchema.model_validate(r) for r in records]
    )

@router.get("/{user_id}", response_model=UserSchema)
def get_user(
    user_id: int,
    env: Annotated[Environment, Depends(odoo_env)]
):
    record = env["res.users"].browse(user_id)
    if not record.exists():
        raise HTTPException(status_code=404, detail="User not found")
    return UserSchema.model_validate(record)

@router.post("/", response_model=UserSchema, status_code=status.HTTP_201_CREATED)
def create_user(
    data: UserCreate,
    env: Annotated[Environment, Depends(odoo_env)]
):
    vals = data.model_dump(exclude_unset=True)
    record = env["res.users"].sudo().create(vals)
    return UserSchema.model_validate(record)

@router.put("/{user_id}", response_model=UserSchema)
def update_user(
    user_id: int,
    data: UserUpdate,
    env: Annotated[Environment, Depends(odoo_env)]
):
    record = env["res.users"].browse(user_id)
    if not record.exists():
        raise HTTPException(status_code=404, detail="User not found")
    vals = data.model_dump(exclude_unset=True)
    record.sudo().write(vals)
    return UserSchema.model_validate(record)

@router.delete("/{user_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_user(
    user_id: int,
    env: Annotated[Environment, Depends(odoo_env)]
):
    record = env["res.users"].browse(user_id)
    if not record.exists():
        raise HTTPException(status_code=404, detail="User not found")
    record.sudo().unlink()
    return None
