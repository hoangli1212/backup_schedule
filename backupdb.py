import os
import shutil
import smtplib
import schedule
import time
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from dotenv import load_dotenv
from datetime import datetime

# Load biến môi trường
load_dotenv()

sender_email = os.getenv("SENDER_EMAIL")
sender_password = os.getenv("SENDER_PASSWORD")
receiver_email = os.getenv("RECEIVER_EMAIL")
if not sender_email or not sender_password or not receiver_email:
    raise ValueError("Thiếu biến môi trường! Kiểm tra lại file .env")
file_SQL = 'D:/RPA/BaiTap/Backup/QuanLyDeAn.sql'  # Đây là file, không phải folder
backup_folder = 'D:/RPA/BaiTap/Backup/backup'

def send_email(subject, body):
    message = MIMEMultipart()
    message["From"] = sender_email
    message["To"] = receiver_email
    message["Subject"] = subject
    message.attach(MIMEText(body, "plain"))

    try:
        server = smtplib.SMTP("smtp.gmail.com", 587)
        server.starttls()
        server.login(sender_email, sender_password)
        server.sendmail(sender_email, receiver_email, message.as_string())
        server.quit()
        print("Email đã được gửi")
    except Exception as e:
        print(f"Có lỗi xảy ra khi gửi email: {e}")

def backup_database():
    try:
        if not os.path.isfile(file_SQL):
            send_email("Backup thất bại", f"Không tìm thấy file {file_SQL}")
            return

        os.makedirs(backup_folder, exist_ok=True)

        now = datetime.now().strftime("%Y%m%d_%H%M%S")
        filename = os.path.basename(file_SQL) 
        backup_path = os.path.join(backup_folder, f"{now}_{filename}")

        shutil.copy2(file_SQL, backup_path)

        send_email("Backup thành công", f"Đã backup file: {filename}")
    except Exception as e:
        send_email("Backup thất bại", f"Lỗi: {e}")


schedule.every().day.at("00:00").do(backup_database)

print("Chương trình backup đang chạy...")

while True:
    schedule.run_pending()
    time.sleep(60)