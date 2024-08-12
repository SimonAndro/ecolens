import logging
from fastapi import FastAPI
from app.routes import image

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = FastAPI()

app.include_router(image.router)

@app.on_event("startup")
async def startup_event():
    logger.info("Starting up the FastAPI application")

@app.on_event("shutdown")
async def shutdown_event():
    logger.info("Shutting down the FastAPI application")