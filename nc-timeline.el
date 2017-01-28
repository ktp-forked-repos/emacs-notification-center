(defconst nc-timeline/-fontawesome-available-p
  (member "FontAwesome" (font-family-list))
  "Non-nil iff `FontAwesome' font is available.")

;; + utilities

(defun nc-timeline/make-button (str action &rest props)
  "Make a string button and return it. When the string is
clicked, ACTION is called with the button-object, which you can
retrieve PROPS from with (button-get BUTTON PROPNAME). This is
NOT a destructive function unlike `make-text-button'."
  (declare (indent 1))
  (let ((str (copy-sequence str)))
    (apply 'make-text-button str 0 'action action props)
    str))

(defun nc-timeline/make-link (str url)
  "Like `nc-timeline/make-button' but use predefined action which
opens a browser and navigates to URL."
  (declare (indent 1))
  (nc-timeline/make-button str (lambda (b) (browse-url (button-get b 'url))) 'url url))

(provide 'nc-timeline)
