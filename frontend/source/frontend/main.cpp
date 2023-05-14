#include <frontend/main_page.hpp>

#include <nui/core.hpp>
#include <nui/window.hpp>

#include <nui/frontend/dom/dom.hpp>

extern "C" void frontendMain() {
  thread_local MainPage mainPage;
  thread_local Nui::Dom::Dom dom;
  dom.setBody(mainPage.render());
}

EMSCRIPTEN_BINDINGS(nui_example_frontend) {
  emscripten::function("main", &frontendMain);
}
#include <nui/frontend/bindings.hpp>