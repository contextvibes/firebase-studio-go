package cmd

import (
	"fmt"
	"os"

	"github.com/spf13/cobra"
)

var name string

// rootCmd represents the base command when called without any subcommands
var rootCmd = &cobra.Command{
	Use:   "my-cli",
	Short: "A brief description of your application",
	Long: `A longer description that spans multiple lines and likely contains
examples and usage of using your application.`,
}

// helloCmd represents the hello command
var helloCmd = &cobra.Command{
	Use:   "hello",
	Short: "Prints a friendly greeting.",
	Long:  `Prints 'Hello, World!' or a personalized greeting if the --name flag is provided.`,
	Run: func(cmd *cobra.Command, args []string) {
		if name != "" {
			fmt.Printf("Hello, %s!\n", name)
		} else {
			fmt.Println("Hello, World!")
		}
	},
}

// Execute adds all child commands to the root command and sets flags appropriately.
// This is called by main.main(). It only needs to happen once to the rootCmd.
func Execute() {
	err := rootCmd.Execute()
	if err != nil {
		os.Exit(1)
	}
}

func init() {
	// Add the hello subcommand to the root command.
	rootCmd.AddCommand(helloCmd)

	// Add a persistent --name flag to the hello command.
	helloCmd.Flags().StringVarP(&name, "name", "n", "", "Name to greet (optional)")
}
