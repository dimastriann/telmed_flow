from odoo import fields, models
from ..routers.partner_router import router as contact_router
from ..routers.company_router import router as company_router
from ..routers.user_router import router as user_router

class FastapiEndpoint(models.Model):
    _inherit = "fastapi.endpoint"

    app: str = fields.Selection(
        selection_add=[("telmed_flow", "TelMedFlow")],
        ondelete={"telmed_flow": "cascade"}
    )

    def _get_fastapi_routers(self):
        if self.app == "telmed_flow":
            return [contact_router, company_router, user_router]
        return super()._get_fastapi_routers()
