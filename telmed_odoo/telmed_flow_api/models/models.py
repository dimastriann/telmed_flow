# from odoo import models, fields, api


# class telmed_flow_api(models.Model):
#     _name = 'telmed_flow_api.telmed_flow_api'
#     _description = 'telmed_flow_api.telmed_flow_api'

#     name = fields.Char()
#     value = fields.Integer()
#     value2 = fields.Float(compute="_value_pc", store=True)
#     description = fields.Text()
#
#     @api.depends('value')
#     def _value_pc(self):
#         for record in self:
#             record.value2 = float(record.value) / 100

