clear;
test_model = ILLIQModel();
server=QuantPlatform();
server.InitializePlatform('E:\nffund\QuantPlatform\temp\AllinOne', 20150617);
[out_1, out_2] = test_model.ModelPort(server, 20150617);