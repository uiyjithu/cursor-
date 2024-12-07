<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resume Upload</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }
        .upload-container {
            border: 2px dashed #ccc;
            padding: 20px;
            text-align: center;
            margin: 20px 0;
        }
        .button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <h1>Resume Upload</h1>
    <div class="upload-container">
        <form action="/upload" method="post" enctype="multipart/form-data">
            <h2>Upload Your Resume</h2>
            <p>Supported formats: PDF, DOC, DOCX</p>
            <input type="file" name="resume" accept=".pdf,.doc,.docx" required>
            <br><br>
            <button type="submit" class="button">Upload Resume</button>
        </form>
    </div>
    <div id="message"></div>

    <script>
        document.querySelector('form').addEventListener('submit', async (e) => {
            e.preventDefault();
            const formData = new FormData(e.target);
            
            try {
                const response = await fetch('/upload', {
                    method: 'POST',
                    body: formData
                });
                
                const result = await response.text();
                document.getElementById('message').innerHTML = `<p style="color: green;">${result}</p>`;
            } catch (error) {
                document.getElementById('message').innerHTML = `<p style="color: red;">Error uploading file: ${error}</p>`;
            }
        });
    </script>
</body>
</html>
