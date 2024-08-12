import google.generativeai as genai 
from io import BytesIO
import PIL.Image
import requests

from app.config import settings, PROMPT

genai.configure(api_key=settings.gemini_api_key)

def get_recommendations(image_bytes: bytes) -> dict:

    img = PIL.Image.open(BytesIO(image_bytes))
    model = genai.GenerativeModel("gemini-1.5-flash")

    response = model.generate_content([PROMPT, img])
    response.resolve()

    data = dict()
    data['recommendations'] = response.text
    
    return data
