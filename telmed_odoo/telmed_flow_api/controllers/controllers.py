# from odoo import http


# class TelmedFlowApi(http.Controller):
#     @http.route('/telmed_flow_api/telmed_flow_api', auth='public')
#     def index(self, **kw):
#         return "Hello, world"

#     @http.route('/telmed_flow_api/telmed_flow_api/objects', auth='public')
#     def list(self, **kw):
#         return http.request.render('telmed_flow_api.listing', {
#             'root': '/telmed_flow_api/telmed_flow_api',
#             'objects': http.request.env['telmed_flow_api.telmed_flow_api'].search([]),
#         })

#     @http.route('/telmed_flow_api/telmed_flow_api/objects/<model("telmed_flow_api.telmed_flow_api"):obj>', auth='public')
#     def object(self, obj, **kw):
#         return http.request.render('telmed_flow_api.object', {
#             'object': obj
#         })

