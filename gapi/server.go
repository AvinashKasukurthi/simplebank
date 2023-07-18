package gapi

import (
	"fmt"

	db "github.com/avinashkasukurthi/simplebank/db/sqlc"
	"github.com/avinashkasukurthi/simplebank/pb"
	"github.com/avinashkasukurthi/simplebank/token"
	"github.com/avinashkasukurthi/simplebank/util"
)

// Server  servers gRPC requests for our banking se service
type Server struct {
	pb.UnimplementedSimpleBankServer
	config     util.Config
	store      db.Store
	tokenMaker token.Maker
}

func NewServer(config util.Config, store db.Store) (*Server, error) {
	tokenMaker, err := token.NewPasetoMaker(config.TokenSymmetricKey)
	if err != nil {
		return nil, fmt.Errorf("cannot create token maker: %w", err)
	}

	server := &Server{
		config:     config,
		store:      store,
		tokenMaker: tokenMaker,
	}

	return server, nil
}
