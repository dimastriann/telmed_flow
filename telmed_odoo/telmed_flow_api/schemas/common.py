from typing import Generic, TypeVar, List, Any
from pydantic import BaseModel, ConfigDict, field_validator

T = TypeVar("T")

class OdooBase(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    @field_validator("*", mode="before")
    @classmethod
    def convert_odoo_types(cls, v: Any, info: Any) -> Any:
        # Odoo returns False for empty fields.
        if v is False:
            # For Boolean fields, False is a valid value.
            # For String fields, return an empty string as requested.
            field_name = info.field_name
            if field_name in cls.model_fields:
                annotation = cls.model_fields[field_name].annotation
                # Check if the field is/contains bool
                if annotation is bool:
                    return False
                # Check if the field is/contains str (handles str, Optional[str], etc.)
                if annotation is str or (hasattr(annotation, "__args__") and str in annotation.__args__):
                    return ""
            return None
        # Handle many2one recordsets by returning the ID
        if hasattr(v, "_name") and hasattr(v, "ids"):
            return v.id if v else None
        return v

class CollectionResponse(BaseModel, Generic[T]):
    count: int
    items: List[T]
