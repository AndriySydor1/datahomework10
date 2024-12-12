FROM python:3.10-slim

# Встановлення системних залежностей для компіляції
RUN apt-get update && apt-get install -y \
    build-essential \
    python3-dev \
    curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Встановлення scikit-surprise
RUN pip install scikit-surprise

# Встановлення робочої директорії
WORKDIR /app

# Копіювання файлів проекту до контейнера
COPY . /app

# Встановлення залежностей з requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Команда для запуску вашої програми
CMD ["python", "main.py"]

# Встановлення Jupyter
RUN pip install --no-cache-dir notebook

# Відкриття порту для Jupyter
EXPOSE 8888

# Запуск Jupyter Notebook
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
