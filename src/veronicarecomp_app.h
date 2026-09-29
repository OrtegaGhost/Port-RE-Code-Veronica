// veronicarecomp - ReXGlue Recompiled Project
//
// veronicarecomp ReXApp

#pragma once

#include <rex/rex_app.h>
#include <veronicarecomp_settings.h>

namespace CodeVeronica {
  class VeronicarecompApp : public rex::ReXApp {
    public:
      using rex::ReXApp::ReXApp;

      static std::unique_ptr<rex::ui::WindowedApp> Create(
          rex::ui::WindowedAppContext& ctx) {
        return std::unique_ptr<VeronicarecompApp>(new VeronicarecompApp(ctx, "veronicarecomp", PPCImageConfig));
      }

      void OnPreSetup(rex::RuntimeConfig& config) override {
        config.gpu_plugin = "xenos";
      }

      void OnPostSetup() override{
          InitializeDefaultSettings(window());
      }

      void OnConfigurePaths(rex::PathConfig& paths) override {
        SetDefaultPaths(paths);
      }
    };
}