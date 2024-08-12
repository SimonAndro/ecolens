from fastapi import APIRouter, File, UploadFile, HTTPException
from app.utils.gemini_client import get_recommendations
from pydantic import BaseModel
import requests

router = APIRouter()

class Recommendations(BaseModel):
    recommendations: str

@router.post("/upload-image", response_model=Recommendations)
async def upload_image(file: UploadFile = File(...)):
    try:
        # Read image file
        image_bytes = await file.read()
        data = get_recommendations(image_bytes)
        return Recommendations(recommendations=data.get("recommendations", "No recommendations available"))
    except requests.RequestException as e:
        raise HTTPException(status_code=500, detail=f"Google Gemini API error: {e}")
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Unexpected error: {e}")
