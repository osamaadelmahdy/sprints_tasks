def mutate_string(string, position, character):
    string_list = list(string)
    string_list[position] = character
    modified_string = "".join(string_list)
    return modified_string

original_string = "abracadabra"
modified_string = mutate_string(original_string, 5, "k")
print(modified_string) 
