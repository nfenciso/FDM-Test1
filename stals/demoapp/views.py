#from django.shortcuts import render
#from django.http import HttpResponse
#from django.template import loader
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .serializers import TodoSerializer
from .models import Todo
# Create your views here.

@api_view(['GET'])
def get_todos(request):
  mydata = Todo.objects.values()
  #template = loader.get_template('demoapp/todos.html')
  #context = {
  #  'mytodos': mydata,
  #}
  #return HttpResponse(template.render(context, request))
  return Response(mydata)

#@api_view(['GET'])
#def get_todos2(request):
#  todos = Todo.objects.all()
#  serializer = TodoSerializer(todos, many=True)
#  return Response(serializer.data)

@api_view(['GET'])
def get_todo(request, pk):
  mydata = Todo.objects.filter(id=pk).values()
  return Response(mydata)

@api_view(['POST'])
def create_todo(request):
  data = request.data

  todo = Todo.objects.create(
    task = data['task'],
    description = data['description']
  )
  serializer = TodoSerializer(todo, many=False)

  return Response(serializer.data)

@api_view(['PUT'])
def update_todo(request, pk):
  data = request.data

  todo = Todo.objects.get(id=pk)
  serializer = TodoSerializer(todo, data=data)
  if serializer.is_valid():
    serializer.save()

  return Response(serializer.data)

@api_view(['DELETE'])
def delete_todo(request, pk):
  todo = Todo.objects.get(id=pk)
  todo.delete()
  return Response("Todo was deleted!")