using Microsoft.AspNetCore.Localization;
using OnlineRezervacijaAvioKarata.Filters;
using System.Globalization;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();

//Custom filteri za autorizaciju
builder.Services.AddScoped<LoginRequiredFilter>();
builder.Services.AddScoped<AdminRequiredFilter>();

//session
builder.Services.AddDistributedMemoryCache();
builder.Services.AddSession(options =>
{
    options.IdleTimeout = TimeSpan.FromMinutes(60);
    options.Cookie.HttpOnly = true;
    options.Cookie.IsEssential = true;
});

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();

app.UseStaticFiles();

app.UseRouting();

app.UseAuthorization();

app.UseSession();

app.MapControllerRoute(
    name: "odabirKarata",
    pattern: "{controller=Home}/{action=Index}/{brLeta}/{datumPolaska}/{klasa}");
app.MapControllerRoute(
    name: "odabirKlase",
    pattern: "{controller=Home}/{action=Index}/{brLeta}/{datumPolaska}");
app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();
