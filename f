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
        #message {
            margin-top: 20px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <h1>Resume Upload</h1>
    <div class="upload-container">
        <form id="uploadForm">
            <h2>Upload Your Resume</h2>
            <p>Supported formats: PDF, DOC, DOCX (Max size: 5MB)</p>
            <input type="file" name="resume" id="resumeInput" accept=".pdf,.doc,.docx" required>
            <br><br>
            <button type="submit" class="button">Upload Resume</button>
        </form>
    </div>
    <div id="message"></div>

    <script>
        // Select the form and file input elements
        const form = document.getElementById('uploadForm');
        const fileInput = document.getElementById('resumeInput');
        const messageDiv = document.getElementById('message');

        // Client-side file validation
        fileInput.addEventListener('change', () => {
            const file = fileInput.files[0];
            const allowedExtensions = ['pdf', 'doc', 'docx'];
            const maxFileSize = 5 * 1024 * 1024; // 5MB

            // Check file extension
            if (!allowedExtensions.some(ext => file.name.toLowerCase().endsWith(ext))) {
                alert('Invalid file type. Please upload a PDF, DOC, or DOCX file.');
                fileInput.value = ''; // Clear the input
                return;
            }

            // Check file size
            if (file.size > maxFileSize) {
                alert('File is too large. Maximum size is 5MB.');
                fileInput.value = ''; // Clear the input
            }
        });

        // Handle form submission
        form.addEventListener('submit', async (e) => {
            e.preventDefault();

            // Show a loading message
            messageDiv.innerHTML = `<p style="color: blue;">Uploading...</p>`;

            // Prepare form data for submission
            const formData = new FormData(form);

            try {
                // Send the file to the server
                const response = await fetch('/upload', {
                    method: 'POST',
                    body: formData,
                });

                // Parse and handle the response
                const result = await response.json();
                if (response.ok) {
                    messageDiv.innerHTML = `<p style="color: green;">${result.message || "File uploaded successfully!"}</p>`;
                } else {
                    messageDiv.innerHTML = `<p style="color: red;">${result.error || "Failed to upload file."}</p>`;
                }
            } catch (error) {
                // Handle any errors during the fetch
                messageDiv.innerHTML = `<p style="color: red;">Error uploading file: ${error.message}</p>`;
            }
        });
    </script>
</body>
</html>
