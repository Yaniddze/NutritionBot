FROM python:3.12-slim

# Исправлено: libgl1-mesa-glx заменен на libgl1 для актуальных версий Debian
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libjpeg62-turbo \
    zlib1g \
    poppler-utils \
    tesseract-ocr \
    ffmpeg \
    libgl1 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Устанавливаем зависимости
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Копируем исходный код
# Предполагается, что точка входа (main.py) находится в папке src
COPY ./src /app/src
WORKDIR /app/src

# Запуск бота
CMD ["python", "NutritionBot.py"]