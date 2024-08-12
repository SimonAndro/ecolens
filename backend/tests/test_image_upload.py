from fastapi.testclient import TestClient
from app.main import app
from pathlib import Path

client = TestClient(app)


def test_upload_image():
    image_path = Path(__file__).parent / "images" / "test_image.jpeg"
    with open(image_path, "rb") as image_file:
        response = client.post("/upload-image", files={"file": ("test_image.jpeg", image_file, "image/jpeg")})
        print(response.text)

    assert response.status_code == 200
    assert "recommendations" in response.json()
