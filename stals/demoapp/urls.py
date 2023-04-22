from django.urls import path
from . import views
urlpatterns = [
 path("todos/", views.get_todos),
 path("todos/create/", views.create_todo),
 path("todos/<str:pk>/update/", views.update_todo),
 path("todos/<str:pk>/delete/", views.delete_todo),
 path("todos/<str:pk>/", views.get_todo),
]