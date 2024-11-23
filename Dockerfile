FROM openjdk:24
WORKDIR /app
COPY BlackJack.jar /app/blackjack.jar

# Обновление списка пакетов и установка необходимых утилит
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Установка xfce4, tightvncserver и novnc
RUN apt-get update && apt-get install -y \
    xfce4 \
    tightvncserver \
    novnc \
    websockify \
    && apt-get clean

# Установка пароля для VNC
RUN mkdir ~/.vnc \
    && echo "password" | vncpasswd -f > ~/.vnc/passwd \
    && chmod 600 ~/.vnc/passwd

# Установка среды рабочего стола XFCE4 (или другой легкой среды)
CMD ["vncserver", ":1", "-geometry", "1280x800", "-depth", "24"]

ENTRYPOINT ["java","-jar", "blackjack.jar"]

