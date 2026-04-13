{
    'name': "TelMedFlow API",
    'summary': "API for TelMedFlow",
    'description': """API for TelMedFlow""",
    'author': "dimastriann",
    'website': "https://github.com/dimastriann",
    # Categories can be used to filter modules in modules listing
    # Check https://github.com/odoo/odoo/blob/15.0/odoo/addons/base/data/ir_module_category_data.xml
    # for the full list
    'category': 'Uncategorized',
    'version': '0.1',
    # any module necessary for this one to work correctly
    'depends': ['fastapi'],
    # always loaded
    'data': [
        #'security/ir.model.access.csv',
        'data/fastapi_data.xml',
        'views/views.xml',
        'views/templates.xml',
    ],
    # only loaded in demonstration mode
    'demo': [
        'demo/demo.xml',
    ],
    "license": "LGPL-3",
}
