<?php

?>
<div class="form-grid">

  <div class="form-group">
    <label for="STUDENT_NO">Student No. *</label>
    <input type="text" id="STUDENT_NO" name="STUDENT_NO" required
           value="<?= htmlspecialchars($form['STUDENT_NO']) ?>">
  </div>

  <div class="form-group">
    <label for="GENDER">Gender</label>
    <select id="GENDER" name="GENDER">
      <option value="">-- Select --</option>
      <option value="Male" <?= $form['GENDER'] === 'Male' ? 'selected' : '' ?>>Male</option>
      <option value="Female" <?= $form['GENDER'] === 'Female' ? 'selected' : '' ?>>Female</option>
    </select>
  </div>

  <div class="form-group">
    <label for="LASTNAME">Last Name *</label>
    <input type="text" id="LASTNAME" name="LASTNAME" required
           value="<?= htmlspecialchars($form['LASTNAME']) ?>">
  </div>

  <div class="form-group">
    <label for="FIRSTNAME">First Name *</label>
    <input type="text" id="FIRSTNAME" name="FIRSTNAME" required
           value="<?= htmlspecialchars($form['FIRSTNAME']) ?>">
  </div>

  <div class="form-group">
    <label for="MIDDLENAME">Middle Name</label>
    <input type="text" id="MIDDLENAME" name="MIDDLENAME"
           value="<?= htmlspecialchars($form['MIDDLENAME']) ?>">
  </div>

  <div class="form-group">
    <label for="BIRTHDATE">Birthdate</label>
    <input type="date" id="BIRTHDATE" name="BIRTHDATE"
           value="<?= htmlspecialchars($form['BIRTHDATE']) ?>">
  </div>

  <div class="form-group">
    <label for="CONTACT">Contact No.</label>
    <input type="text" id="CONTACT" name="CONTACT"
           value="<?= htmlspecialchars($form['CONTACT']) ?>">
  </div>

  <div class="form-group">
    <label for="EMAIL">Email</label>
    <input type="email" id="EMAIL" name="EMAIL"
           value="<?= htmlspecialchars($form['EMAIL']) ?>">
  </div>

  <div class="form-group form-group-wide">
    <label for="ADDRESS">Address</label>
    <input type="text" id="ADDRESS" name="ADDRESS"
           value="<?= htmlspecialchars($form['ADDRESS']) ?>">
  </div>

  <div class="form-group">
    <label for="COURSE_ID">Course</label>
    <select id="COURSE_ID" name="COURSE_ID">
      <option value="">-- Select Course --</option>
      <?php foreach ($courses as $c): ?>
        <option value="<?= $c['ID'] ?>" <?= (string)$form['COURSE_ID'] === (string)$c['ID'] ? 'selected' : '' ?>>
          <?= htmlspecialchars($c['COURSE']) ?>
        </option>
      <?php endforeach; ?>
    </select>
  </div>

  <div class="form-group">
    <label for="YEARLEVEL_ID">Year Level</label>
    <select id="YEARLEVEL_ID" name="YEARLEVEL_ID">
      <option value="">-- Select Year Level --</option>
      <?php foreach ($yearlevels as $y): ?>
        <option value="<?= $y['ID'] ?>" <?= (string)$form['YEARLEVEL_ID'] === (string)$y['ID'] ? 'selected' : '' ?>>
          <?= htmlspecialchars($y['YEARLEVEL']) ?>
        </option>
      <?php endforeach; ?>
    </select>
  </div>

  <div class="form-group">
    <label for="SECTION_ID">Section</label>
    <select id="SECTION_ID" name="SECTION_ID">
      <option value="">-- Select Section --</option>
      <?php foreach ($sections as $s): ?>
        <option value="<?= $s['ID'] ?>" <?= (string)$form['SECTION_ID'] === (string)$s['ID'] ? 'selected' : '' ?>>
          <?= htmlspecialchars($s['SECTION']) ?>
        </option>
      <?php endforeach; ?>
    </select>
  </div>

  <div class="form-group">
    <label for="SCHOOLYEAR_ID">School Year</label>
    <select id="SCHOOLYEAR_ID" name="SCHOOLYEAR_ID">
      <option value="">-- Select School Year --</option>
      <?php foreach ($schoolyears as $sy): ?>
        <option value="<?= $sy['ID'] ?>" <?= (string)$form['SCHOOLYEAR_ID'] === (string)$sy['ID'] ? 'selected' : '' ?>>
          <?= htmlspecialchars($sy['SCHOOLYEAR']) ?>
        </option>
      <?php endforeach; ?>
    </select>
  </div>

  <div class="form-group">
    <label for="STATUS">Status</label>
    <select id="STATUS" name="STATUS">
      <option value="Active" <?= $form['STATUS'] === 'Active' ? 'selected' : '' ?>>Active</option>
      <option value="Inactive" <?= $form['STATUS'] === 'Inactive' ? 'selected' : '' ?>>Inactive</option>
      <option value="Graduated" <?= $form['STATUS'] === 'Graduated' ? 'selected' : '' ?>>Graduated</option>
    </select>
  </div>

</div>
