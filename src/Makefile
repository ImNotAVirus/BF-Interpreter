ASM				=	nasm
NAME			=	a.out
SRC				=	main.asm						\
					src/asm_throw.asm				\
					libs/libmy/asm_putstr.asm		\
					libs/libmy/asm_strlen.asm		\
					libs/libmy/asm_putchar.asm

OBJ				=	$(SRC:.asm=.o)
FLAGS			=	-f elf64
RM				=	rm -rf

all             :   $(NAME)

$(NAME)			:	$(OBJ)
					ld $(OBJ)

%.o : %.asm
					$(ASM) $(FLAGS) -o $@ $<

clean			:	
					$(RM) $(OBJ)

fclean			:			clean
					$(RM) $(NAME)

re				:	fclean all

.PHONY			:	re

