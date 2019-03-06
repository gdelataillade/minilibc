##
## EPITECH PROJECT, 2019
## Makefile - Gautier de Lataillade
## File description:
## Standard Makefile
##

SRC		=	./src/strlen.asm	\
			./src/strchr.asm	\
			./src/memset.asm	\
			./src/memcpy.asm	\
			./src/strcmp.asm	\
			./src/strncmp.asm

OBJ		=	$(SRC:.asm=.o)

ASMFLAGS	=	-f elf64

LDFLAGS		=	-shared

NAME		=	libasm.so

ASM		=	nasm

LD		=	ld

RM		=	rm -rf

.SILENT:

%.o:	%.asm
		@printf "Compiled: %s\n" $<
		@$(ASM) -o $@ $< $(ASMFLAGS)

all:		$(NAME)

$(NAME):	$(OBJ) 
		@$(LD) $(LDFLAGS) -o $(NAME) $(OBJ)
		@echo "COMPILATION: OK"

clean:
		@$(RM) $(OBJ)
		@echo "CLEAN: OK"

fclean:		clean
		@$(RM) $(NAME)
		@echo "FCLEAN: OK"

re:		fclean all

.PHONY:		all $(NAME) clean fclean re
