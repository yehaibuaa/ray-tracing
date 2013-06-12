TARGET = test

OBJ_DIR = obj
INCLUDE_DIR = -I.
CXXFLAGS = $(INCLUDE_DIR) -O2 -std=c++11
LINKFLAGS = -lpng -std=c++11

CXX = g++
CXXSOURCES = $(shell find . -name "*.cpp")
OBJS = $(addprefix $(OBJ_DIR)/,$(CXXSOURCES:.cpp=.o))
DEPFILES = $(OBJS:.o=.d)

.PHONY: all clean
all: $(TARGET)

$(OBJ_DIR)/%.o: %.cpp
	$(CXX) -c $< -o $@ $(CXXFLAGS)

$(OBJ_DIR)/%.d: %.cpp
	@mkdir -pv $(dir $@)
	$(CXX) $(INCLUDE_DIR) -MM -MT "$(OBJ_DIR)/$(<:.cpp=.o) $(OBJ_DIR)/$(<:.cpp=.d)" "$<"  > "$@"

sinclude $(DEPFILES)

$(TARGET): $(OBJS)
	$(CXX) $(OBJS) -o $@ $(LINKFLAGS)

clean:
	rm -rf $(OBJ_DIR) $(TARGET)