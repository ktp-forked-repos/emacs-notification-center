;; + utility fns

;; API
(defconst nc-timeline/-fontawesome-available-p (member "FontAwesome" (font-family-list)))
(defun nc-timeline/fontawesome-icon (codepoint fallback-str &optional face)
  "Return a string of a FontAwesome icon, or FALLBACK-STR if
FontAwesome font is not installed. Returned string will be
propertized with face FACE (either a face symbol or a plist), and
its `face' property should not be modified later."
  (cond (nc-timeline/-fontawesome-available-p
         (propertize (char-to-string codepoint) 'face
                     (cond ((null face) '(:family "FontAwesome"))
                           ((symbolp face) `(:family "FontAwesome" :inherit ,face))
                           ((listp face) `(:family "FontAwesome" ,@face)))))
        (t
         (propertize fallback-str 'face face))))

;; API
(defun nc-timeline/make-button (str action &rest props)
  "Make a string button and return it. When the string is
clicked, ACTION is called with the button-object, which you can
retrieve PROPS from with (button-get BUTTON PROPNAME). This is
NOT a destructive function unlike `make-text-button'."
  (declare (indent 1))
  (let ((str (copy-sequence str)))
    (apply 'make-text-button str 0 'action action props)
    str))

;; API
(defun nc-timeline/make-link (str url)
  "Like `nc-timeline/make-button' but use predefined action which
opens a browser and navigates to URL."
  (declare (indent 1))
  (nc-timeline/make-button str (lambda (b) (browse-url (button-get b 'url))) 'url url))

(provide 'nc-timeline)
