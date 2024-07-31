# UI_Testing/environment.py

def before_all(context):
    pass

def after_all(context):
    if hasattr(context, 'driver'):
        context.driver.quit()