<?php
/**
 * Photo upload helper for instructors.
 * Returns [storedFilename|null, errorMessage|null]. No file chosen => [null, null].
 */
const INSTRUCTOR_UPLOAD_DIR = __DIR__ . '/../uploads/instructors/';
const INSTRUCTOR_UPLOAD_URL = 'uploads/instructors/';

function handleInstructorPhoto(string $field = 'PHOTO'): array
{
    if (empty($_FILES[$field]) || $_FILES[$field]['error'] === UPLOAD_ERR_NO_FILE) {
        return [null, null];
    }
    $f = $_FILES[$field];

    if ($f['error'] !== UPLOAD_ERR_OK) return [null, "Photo upload failed. Please try again."];
    if ($f['size'] > 2 * 1024 * 1024)  return [null, "Photo must be 2 MB or smaller."];

    $allowed = ['image/jpeg' => 'jpg', 'image/png' => 'png', 'image/gif' => 'gif', 'image/webp' => 'webp'];
    $mime = (new finfo(FILEINFO_MIME_TYPE))->file($f['tmp_name']);
    if (!isset($allowed[$mime]) || @getimagesize($f['tmp_name']) === false) {
        return [null, "Photo must be a JPG, PNG, GIF or WEBP image."];
    }

    if (!is_dir(INSTRUCTOR_UPLOAD_DIR)) mkdir(INSTRUCTOR_UPLOAD_DIR, 0755, true);
    $name = bin2hex(random_bytes(12)) . '.' . $allowed[$mime];
    if (!move_uploaded_file($f['tmp_name'], INSTRUCTOR_UPLOAD_DIR . $name)) {
        return [null, "Could not save the uploaded photo."];
    }
    return [$name, null];
}

function deleteInstructorPhoto(?string $file): void
{
    if ($file && preg_match('/^[a-f0-9]{24}\.(jpg|png|gif|webp)$/', $file)) {
        @unlink(INSTRUCTOR_UPLOAD_DIR . $file);
    }
}

function instructorPhotoHtml(?string $file, string $class = 'thumb'): string
{
    if ($file && preg_match('/^[a-f0-9]{24}\.(jpg|png|gif|webp)$/', $file)) {
        return '<img class="' . $class . '" src="' . INSTRUCTOR_UPLOAD_URL . htmlspecialchars($file) . '" alt="Instructor photo">';
    }
    return '<span class="' . $class . ' thumb-ph">👤</span>';
}
