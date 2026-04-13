from typing import Generic, TypeVar, List
from pydantic import BaseModel

T = TypeVar("T")

class BatchUpdateItem(BaseModel, Generic[T]):
    id: int
    data: T
