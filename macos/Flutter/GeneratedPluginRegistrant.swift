//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import audio_session
import flutter_image_compress_macos
import image_compression_flutter
import just_audio
import path_provider_foundation
import record_macos

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  AudioSessionPlugin.register(with: registry.registrar(forPlugin: "AudioSessionPlugin"))
  FlutterImageCompressMacosPlugin.register(with: registry.registrar(forPlugin: "FlutterImageCompressMacosPlugin"))
  ImageCompressionFlutterPlugin.register(with: registry.registrar(forPlugin: "ImageCompressionFlutterPlugin"))
  JustAudioPlugin.register(with: registry.registrar(forPlugin: "JustAudioPlugin"))
  PathProviderPlugin.register(with: registry.registrar(forPlugin: "PathProviderPlugin"))
  RecordMacosPlugin.register(with: registry.registrar(forPlugin: "RecordMacosPlugin"))
}
