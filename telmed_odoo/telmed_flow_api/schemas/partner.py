from typing import Optional
from pydantic import BaseModel, ConfigDict

from .common import OdooBase

class PartnerBase(OdooBase):
    name: str
    email: Optional[str] = None
    phone: Optional[str] = None
    mobile: Optional[str] = None
    street: Optional[str] = None
    city: Optional[str] = None
    zip: Optional[str] = None
    country_id: Optional[int] = None
    state_id: Optional[int] = None
    is_company: bool = False

class PartnerCreate(BaseModel):
    name: str
    email: Optional[str] = None
    phone: Optional[str] = None
    mobile: Optional[str] = None
    street: Optional[str] = None
    city: Optional[str] = None
    zip: Optional[str] = None
    country_id: Optional[int] = None
    state_id: Optional[int] = None
    is_company: bool = False

class PartnerUpdate(BaseModel):
    name: Optional[str] = None
    email: Optional[str] = None
    phone: Optional[str] = None
    mobile: Optional[str] = None
    street: Optional[str] = None
    city: Optional[str] = None
    zip: Optional[str] = None
    country_id: Optional[int] = None
    state_id: Optional[int] = None
    is_company: Optional[bool] = None

class PartnerSchema(PartnerBase):
    id: int
    image_1920: Optional[str] = None
