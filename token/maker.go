package token

import "time"

// Maker is an interface for managing tokens
type Maker interface {
	// CreateToken creates a new token for specific username and duration
	CreateToken(username string, duration time.Duration) (string, error) 
	
	// VerifyToken will check weather the token is valid or not
	VerifyToken(token string) (*Payload, error)   
}