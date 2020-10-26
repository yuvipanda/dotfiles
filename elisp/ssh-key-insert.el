                                        ; From http://ergoemacs.org/emacs/elisp_read_file_content.html
(defun get-string-from-file (filePath)
  "Return filePath's file content."
  (with-temp-buffer
    (insert-file-contents filePath)
    (buffer-string)))

(defun wat (file-name)
  (with-temp-buffer
    (insert-file-contents file-name)
    (mapconcat (lambda (s) (concat "    " s))
               (split-string (buffer-string) "\n" t)
               "\n"
               ))
  )


(defun generate-ssh-key ()
  (interactive)
  (let ((key-file-name (make-temp-name "ssh-key")))
    (shell-command (concat "ssh-keygen -q -N '' -f"  key-file-name))
    (insert (wat key-file-name))
    (delete-file key-file-name)
    )
  )

(wat "README.md")
