# from odoo import http


# class TelmedFlowBase(http.Controller):
#     @http.route('/telmed_flow_base/telmed_flow_base', auth='public')
#     def index(self, **kw):
#         return "Hello, world"

#     @http.route('/telmed_flow_base/telmed_flow_base/objects', auth='public')
#     def list(self, **kw):
#         return http.request.render('telmed_flow_base.listing', {
#             'root': '/telmed_flow_base/telmed_flow_base',
#             'objects': http.request.env['telmed_flow_base.telmed_flow_base'].search([]),
#         })

#     @http.route('/telmed_flow_base/telmed_flow_base/objects/<model("telmed_flow_base.telmed_flow_base"):obj>', auth='public')
#     def object(self, obj, **kw):
#         return http.request.render('telmed_flow_base.object', {
#             'object': obj
#         })

