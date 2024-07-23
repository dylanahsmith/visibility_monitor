#include <ruby.h>

VALUE sym_public, sym_protected, sym_private;
ID intern_visibility_set;

static VALUE visibility_set(int argc, VALUE *argv, VALUE mod, VALUE visibility_sym) {
    if (argc > 0) {
        for (int i = 0; i < argc; i++) {
            VALUE method_name = argv[i];
            ID id = rb_check_id(&method_name);
            if (id) {
                method_name = rb_id2sym(id);
            }
            rb_call_super(1, &method_name);
            rb_funcall(mod, intern_visibility_set, 2, method_name, visibility_sym);
        }
        return mod;
    } else {
        return rb_call_super(argc, argv);
    }
}

static VALUE monitor_public(int argc, VALUE *argv, VALUE mod) {
    return visibility_set(argc, argv, mod, sym_public);
}

static VALUE monitor_protected(int argc, VALUE *argv, VALUE mod) {
    return visibility_set(argc, argv, mod, sym_protected);
}

static VALUE monitor_private(int argc, VALUE *argv, VALUE mod) {
    return visibility_set(argc, argv, mod, sym_private);
}

static VALUE monitor_set_visibility_placeholder(VALUE mod, VALUE method_name, VALUE visibility_sym) {
    return Qnil;
}

void Init_visibility_monitor(void) {
    VALUE mVisibilityMonitor = rb_define_module("VisibilityMonitor");

    rb_define_method(mVisibilityMonitor, "public", monitor_public, -1);
    rb_define_method(mVisibilityMonitor, "protected", monitor_protected, -1);
    rb_define_method(mVisibilityMonitor, "private", monitor_private, -1);
    rb_define_method(mVisibilityMonitor, "visibility_set", monitor_set_visibility_placeholder, 2);

    sym_public = RB_ID2SYM(rb_intern("public"));
    sym_protected = RB_ID2SYM(rb_intern("protected"));
    sym_private = RB_ID2SYM(rb_intern("private"));
    intern_visibility_set = rb_intern("visibility_set");
}
