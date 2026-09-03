def main(context):
    context.log("Hello from send_phone_otp!")

    return context.res.json({
        "success": True,
        "message": "Function is working"
    })