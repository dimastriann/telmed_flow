from typing import Optional
from pydantic import BaseModel, ConfigDict

from .common import OdooBase

class CompanyBase(OdooBase):
    name: str
    email: Optional[str] = None
    phone: Optional[str] = None
    website: Optional[str] = None
    vat: Optional[str] = None

class CompanyCreate(BaseModel):
    name: str
    email: Optional[str] = None
    phone: Optional[str] = None
    website: Optional[str] = None
    vat: Optional[str] = None

class CompanyUpdate(BaseModel):
    name: Optional[str] = None
    email: Optional[str] = None
    phone: Optional[str] = None
    website: Optional[str] = None
    vat: Optional[str] = None

class CompanySchema(CompanyBase):
    id: int
