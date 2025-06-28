// internal/config/config.go
package config

import (
	"fmt"

	"github.com/duizendstra/dui-go/env"
)

// Config holds application configuration values loaded from the environment.
// Struct tags define the corresponding environment variables, defaults, and requirements.
type Config struct {
	ServiceName string `env:"API_SERVICE_NAME" envDefault:"go-hello-world-api"`
	Port        string `env:"PORT" envDefault:"8080"`
	ProjectID string `env:"GOOGLE_CLOUD_PROJECT" envRequired:"true"`
}

// Load configuration from environment variables using the dui-go/env library.
func Load() (Config, error) {
	var cfg Config
	err := env.Process(&cfg)
	if err != nil {
		return Config{}, fmt.Errorf("failed to load config from environment: %w", err)
	}
	return cfg, nil
}