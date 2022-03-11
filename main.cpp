#include <iostream>




int main() {
  json j;
  j["name"] = "John Doe";
  std::cout << "Hello, World!" << std::endl;
  spdlog::info("Hello, World2! {}", j.dump());

  auto map_ptr = std::make_unique<tinytmx::Map>();

  map_ptr->ParseFile("test.tmx");
  std::cout << "Map width: " << map_ptr->GetWidth() << std::endl;
  std::cout << "Map height: " << map_ptr->GetHeight() << std::endl;
  std::cout << "Map tile width: " << map_ptr->GetTileWidth() << std::endl;
  std::cout << "Map tile height: " << map_ptr->GetTileHeight() << std::endl;
  std::cout << "Map orientation: " << map_ptr->GetNumLayers() << std::endl;
  for (const auto* layer : map_ptr->GetLayers()) {
	if (layer->GetLayerType() == tinytmx::LayerType::TMX_LAYERTYPE_TILE) {
	  const auto* l = dynamic_cast<const tinytmx::TileLayer *>(layer);
	  std::cout << "Layer name: " << l->GetName() << std::endl;
	  std::cout << "Layer width: " << l->GetWidth() << std::endl;
	  std::cout << "Layer height: " << l->GetHeight() << std::endl;
	  std::cout << "Layer opacity: " << l->GetOpacity() << std::endl;
	  std::cout << "Layer visible: " << l->IsVisible() << std::endl;
	}
	std::cout << "Layer name: " << layer->GetName() << std::endl;
	std::cout << "Layer width: " << (int)layer->GetLayerType() << std::endl;
  }

  return 0;
}
