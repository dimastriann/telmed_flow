from typing import Optional, List
from pydantic import BaseModel, ConfigDict

from .common import OdooBase

class UserBase(OdooBase):
    login: str
    name: str
    email: Optional[str] = None
    active: bool = True
    lang: Optional[str] = None
    tz: Optional[str] = None

class UserCreate(BaseModel):
    login: str
    name: str
    email: Optional[str] = None
    active: bool = True
    lang: Optional[str] = None
    tz: Optional[str] = None
    password: str
    company_id: Optional[int] = None
    partner_id: Optional[int] = None

class UserUpdate(BaseModel):
    name: Optional[str] = None
    email: Optional[str] = None
    active: Optional[bool] = None
    lang: Optional[str] = None
    tz: Optional[str] = None
    signature: Optional[str] = None

class UserSchema(UserBase):
    id: int
    partner_id: int
    company_id: int
    signature: Optional[str] = None
    # groups_id: List[int] = [] # Many2Many can complex to serialize directly
