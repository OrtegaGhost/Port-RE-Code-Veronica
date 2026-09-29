// veronicarecomp - ReXGlue Recompiled Project
//
// Code Veronica RexGue Cvars

#pragma once

#include <rex/rex_app.h>
#include <rex/cvar.h>
#include <rex/ui/keybinds.h>
#include <iostream>
#include <string>
#include <unordered_map>
#include <format>

namespace CodeVeronica {
    void SetDefaultPaths(rex::PathConfig& paths);
    void InitializeDefaultSettings(rex::ui::Window *curWindow);

    static std::string _version = "0.0.1"; // Application version
    static std::vector<std::pair<std::string, std::string>> _defaultConfig = { // Default Settings
        //Display Settings
        {"window_width","1920"},
        {"window_height","1080"},
        {"video_mode_width","1920"},
        {"video_mode_height","1080"},

        //Graphic Settings
        {"native_2x_msaa", "true"},
        {"anisotropic_override", "2"},
        {"resolution_scale", "2"},
        {"snorm16_render_target_full_range", "false"}, // It breaks lighting when enabled!

        //Vsync
        {"vsync","true"},
        {"video_mode_refresh_rate","60"},

        //DX12
        {"render_target_path_d3d12","rtv"}, 
        {"d3d12_readback_resolve", "false"}, 
        {"d3d12_readback_memexport", "false"}, 
        {"d3d12_submit_on_primary_buffer_end", "false"}, 
        {"d3d12_allow_variable_refresh_rate_and_tearing","true"},

        //Vulkan
        {"vulkan_allow_present_mode_immediate", "true"},

        //Texture cache
        {"texture_cache_memory_limit_render_to_texture","256"},
        {"texture_cache_memory_limit_soft","4096"},
        {"texture_cache_memory_limit_hard","8192"},
        {"texture_cache_memory_limit_soft_lifetime","3600"},

        //Other
        {"audio_maxqframes","16"}, // Increasing might reduce performance
        {"readback_resolve", "full"}, // Increases performance when set to full.
        {"readback_memexport", "false"}, 
        {"clear_memory_page_state", "false"}, // Performance gain by reducing CPU overhead. Could also cause instability.
        ///{"execute_unclipped_draw_vs_on_cpu", "true"},
        {"gpu_allow_invalid_fetch_constants", "false"},
    };
}