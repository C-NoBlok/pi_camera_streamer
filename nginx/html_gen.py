import socket
from pathlib import Path

local_dir = Path(__file__).parent

def get_ip_address():
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    s.connect(("8.8.8.8", 80))
    return s.getsockname()[0]

def gen_html():
    
    hostname = socket.gethostname()
    ip_address = get_ip_address()

    html_string = f"""
<!DOCTYPE html>
<html>
	<head>
		<title>Live Cam</title>
		<meta charset="UTF-8">
	</head>
<body>
	<video id="video" autoplay="true" controls="controls" src="http://localhost:8080/picam"</video>
</body>
</html>
"""
    html_string = html_string.replace('localhost', ip_address)
    html_string = html_string.replace('Live Cam', hostname)
    return html_string

def gen_file(text):
    with open(local_dir / "html/index.html", "w") as f:
        f.write(text) 

if __name__ == '__main__':
    gen_file(gen_html())


