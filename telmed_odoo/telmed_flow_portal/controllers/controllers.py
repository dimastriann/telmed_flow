# from odoo import http


# class TelmedFlowPortal(http.Controller):
#     @http.route('/telmed_flow_portal/telmed_flow_portal', auth='public')
#     def index(self, **kw):
#         return "Hello, world"

#     @http.route('/telmed_flow_portal/telmed_flow_portal/objects', auth='public')
#     def list(self, **kw):
#         return http.request.render('telmed_flow_portal.listing', {
#             'root': '/telmed_flow_portal/telmed_flow_portal',
#             'objects': http.request.env['telmed_flow_portal.telmed_flow_portal'].search([]),
#         })

#     @http.route('/telmed_flow_portal/telmed_flow_portal/objects/<model("telmed_flow_portal.telmed_flow_portal"):obj>', auth='public')
#     def object(self, obj, **kw):
#         return http.request.render('telmed_flow_portal.object', {
#             'object': obj
#         })

