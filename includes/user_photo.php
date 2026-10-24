<?php
/**
 * User profile photo helper.
 *
 * Photos live in  <project folder>/images/users/  and are ALWAYS named  <username>.JPG
 * (e.g. images/users/Tammy17.JPG). No database column is needed: the username is the key.
 */
const USER_PHOTO_DIR = __DIR__ . '/../images/users/';
const USER_PHOTO_URL = 'images/users/';
const USER_PHOTO_EXT = '.JPG';
const USER_PHOTO_MAX = 2 * 1024 * 1024;   // 2 MB

/** Only usernames made of letters, numbers, _ and . are allowed to become file names. */
function isSafeUsername(string $username): bool
{
    return (bool)preg_match('/^[A-Za-z0-9_.]{1,100}$/', $username) && strpos($username, '..') === false;
}

function userPhotoFile(string $username): ?string
{
    return isSafeUsername($username) ? USER_PHOTO_DIR . $username . USER_PHOTO_EXT : null;
}

/**
 * Checks the upload field WITHOUT saving it.
 * Returns [hasFile(bool), errorMessage|null].  No file chosen => [false, null] (photo is optional).
 */
function validateUserPhoto(string $field = 'imageUpload'): array
{
    if (empty($_FILES[$field]) || $_FILES[$field]['error'] === UPLOAD_ERR_NO_FILE) {
        return [false, null];
    }
    $f = $_FILES[$field];

    if ($f['error'] === UPLOAD_ERR_INI_SIZE || $f['error'] === UPLOAD_ERR_FORM_SIZE || $f['size'] > USER_PHOTO_MAX) {
        return [false, "Photo must be 2 MB or smaller."];
    }
    if ($f['error'] !== UPLOAD_ERR_OK) {
        return [false, "Sorry, there was an error uploading your file."];
    }

    // Extension check (same allowed types as the sample code)
    $ext = strtolower(pathinfo($f['name'], PATHINFO_EXTENSION));
    if (!in_array($ext, ['jpg', 'jpeg', 'png', 'gif'], true)) {
        return [false, "Invalid file type. Allowed: JPG, JPEG, PNG, GIF."];
    }
    // Real content check: must actually be an image, not just renamed
    $mime = (new finfo(FILEINFO_MIME_TYPE))->file($f['tmp_name']);
    if (!in_array($mime, ['image/jpeg', 'image/png', 'image/gif'], true) || @getimagesize($f['tmp_name']) === false) {
        return [false, "Invalid file type. The file is not a valid JPG, PNG or GIF image."];
    }
    return [true, null];
}

/** Saves the (already validated) upload as images/users/<username>.JPG. Returns an error message or null. */
function saveUserPhoto(string $username, string $field = 'imageUpload'): ?string
{
    $target = userPhotoFile($username);
    if ($target === null) return "Photo not saved: username has characters that can't be used in a file name.";

    if (!is_dir(USER_PHOTO_DIR)) mkdir(USER_PHOTO_DIR, 0755, true);
    $tmp = $_FILES[$field]['tmp_name'];

    // If GD is available, re-encode as a real JPEG so the ".JPG" name matches the content.
    if (function_exists('imagecreatefromstring') && function_exists('imagejpeg')) {
        $img = @imagecreatefromstring((string)file_get_contents($tmp));
        if ($img !== false) {
            // flatten transparency (PNG/GIF) onto white
            $w = imagesx($img); $h = imagesy($img);
            $flat = imagecreatetruecolor($w, $h);
            imagefill($flat, 0, 0, imagecolorallocate($flat, 255, 255, 255));
            imagecopy($flat, $img, 0, 0, 0, 0, $w, $h);
            $ok = imagejpeg($flat, $target, 90);
            imagedestroy($img); imagedestroy($flat);
            return $ok ? null : "Sorry, there was an error uploading your file.";
        }
    }
    return move_uploaded_file($tmp, $target) ? null : "Sorry, there was an error uploading your file.";
}

function renameUserPhoto(string $old, string $new): void
{
    $a = userPhotoFile($old); $b = userPhotoFile($new);
    if ($a && $b && $a !== $b && is_file($a)) @rename($a, $b);
}

function deleteUserPhoto(string $username): void
{
    $f = userPhotoFile($username);
    if ($f && is_file($f)) @unlink($f);
}

/** URL of the user's photo (with a cache-buster), or null when they have none. */
function userPhotoUrl(?string $username): ?string
{
    if ($username === null || $username === '') return null;
    $f = userPhotoFile($username);
    return ($f && is_file($f)) ? USER_PHOTO_URL . rawurlencode($username) . USER_PHOTO_EXT . '?v=' . filemtime($f) : null;
}

/** <img> if the user has a photo, otherwise a 👤 placeholder circle. */
function userPhotoHtml(?string $username, string $class = 'thumb'): string
{
    $url = userPhotoUrl($username);
    if ($url) {
        return '<img class="' . $class . '" src="' . htmlspecialchars($url) . '" alt="' . htmlspecialchars($username) . '">';
    }
    return '<span class="' . $class . ' thumb-ph">👤</span>';
}
