;; Press C-x C-e at the end of the next line to run this file test non-interactively
;; (test-simple-run "emacs -batch -L %s -L %s -l %s" (file-name-directory (locate-library "test-simple.elc")) (file-name-directory (locate-library "realgud.elc")) buffer-file-name)

(require 'test-simple)
(require 'load-relative)
(load-file "../pry/core.el")
(load-file "./regexp-helper.el")

(eval-when-compile
  (defvar realgud:pry-minibuffer-history)
  (defvar test:realgud-pry-executable-save)
  (defvar test:realgud-minibuffer-history-save)
)

(declare-function realgud:pry-suggest-invocation 'realgud:bashdb)
(declare-function __FILE__              'require-relative)

(test-simple-start)

;; Save value realgud:run-process and change it to something we want
(setq test:realgud-pry-executable-save (symbol-function 'realgud:pry-executable))
(setq test:realgud-minibuffer-history-save realgud:pry-minibuffer-history)

;; (defun realgud:pry-executable (filename)
;;   "Mock function for testing"
;;   (cond ((equal filename "bar.sh") 7)
;; 	((equal filename "foo") 8)
;; 	((equal filename "baz") 8)
;; 	(t 3)))

;; (defun pry-test()
;;   (note "realgud:pry-suggest-invocation")
;;   (setq realgud:pry-minibuffer-history nil)
;;   (let ((my-directory (file-name-directory (__FILE__))))
;;     (save-excursion
;;       (note "Test preference to buffer editing")
;;       (setq default-directory
;; 	    (concat my-directory "pry"))
;;       (find-file-literally "foo.c")
;;       (assert-equal "pry foo" (realgud:pry-suggest-invocation)
;; 		    "Should find file sans extension - foo")
;;       (find-file-literally "baz.c")
;;       (assert-equal "pry baz" (realgud:pry-suggest-invocation)
;; 		    "Should find file sans extension - baz")
;;       )
;;     (save-excursion
;;       (note "Pick up non-sans executable")
;;       (setq default-directory
;; 	    (concat my-directory  "pry/test2"))
;;       ;; (assert-equal "pry bar.sh" (realgud:pry-suggest-invocation))
;;       (setq realgud:pry-minibuffer-history '("pry testing"))
;;       (setq default-directory
;; 	    (concat my-directory  "pry/test2"))
;;       (assert-equal "pry testing" (realgud:pry-suggest-invocation)
;; 		    "After setting minibuffer history - takes precidence")
;;       )
;;     (setq default-directory my-directory)
;;     )
;;   )
;; (pry-test)
(end-tests)

;; Restore the old values.
;; You might have to run the below if you run this interactively.
(fset 'realgud:pry-executable test:realgud-pry-executable-save)
(setq realgud:pry-minibuffer-history test:realgud-minibuffer-history-save)
(setq default-directory (file-name-directory (__FILE__)))
