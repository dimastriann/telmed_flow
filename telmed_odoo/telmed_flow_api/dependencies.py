from typing import Annotated
from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer
from odoo.api import Environment
from odoo.addons.fastapi.dependencies import odoo_env, basic_auth_user, authenticated_partner_from_basic_auth_user
from odoo.addons.base.models.res_partner import ResPartner

# OAuth2 setup
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token", auto_error=False)

def get_current_partner(
    env: Annotated[Environment, Depends(odoo_env)],
    token: Annotated[str, Depends(oauth2_scheme)] = None,
    basic_user: Annotated[ResPartner, Depends(authenticated_partner_from_basic_auth_user)] = None
) -> ResPartner:
    """
    Dependency that supports both Basic Auth and (Custom) Bearer Token Auth.
    In this implementation, the token could be an Odoo session ID or a custom JWT.
    """
    if basic_user:
        return basic_user
    
    if token:
        # For simplicity in this first implementation, we will treat the token as a session ID
        # In a real-world scenario, you would decode JWT or check ir.authtoken
        user = env["res.users"].sudo().search([("id", "=", int(token))]) # Placeholder logic
        if user:
            return user.partner_id
            
    raise HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Not authenticated",
        headers={"WWW-Authenticate": "Basic"},
    )
