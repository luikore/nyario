#include <ruby.h>
#include <ruby/encoding.h>
#include "version.inc"

void Init_nyario() {
  VALUE nyario = rb_define_module("Nyario");
  rb_const_set(nyario, rb_intern("VERSION"), rb_enc_str_new(NYARIO_VERSION, strlen(NYARIO_VERSION), rb_utf8_encoding()));
}
