clear;
test_model = ILLIQModel();
server=QuantPlatform();
server.InitializePlatform('E:\nffund\QuantPlatform\temp\AllinOne', 20150617);
t_0 = cputime;
[out_1, out_2] = test_model.ModelPort(server, 20150617);
time_1 = cputime - t_0
server.InstallBackTest(BackTestByMonth(1));
[holding_daily, rtn_daily] = server.BackTest(test_model, 20080101, 20150617);
time_2 = cputime - t_0