
def read_file(file_name)
  file = File.open(file_name, 'r')
  lines = file.readlines
  file.close
  grades = lines.map { |e| e.chomp.split(', ') }
  grades
  # print grades
end


# ------METHOD THAT GENERATES AVERAGE FILE------

def generate_file_average(grades)
  file_name = 'promedios.csv'
  file = File.open(file_name, 'w')


  puts ''
  grades.each do |student|
    student_average = 0.0
    grades_sum = 0.0
    student_name = ''
    student.each_with_index do |value, index|
      if index == 0
        student_name = value
      elsif index > 0
        grades_sum += value.to_f
      end
    end
    total_grades = student.length - 1
    student_average = grades_sum / total_grades
    puts "El Alumno #{student_name} tiene un promedio de #{student_average}."
    file.puts "#{student_name}, #{student_average}"
  end

  puts ''
  puts 'Se ha creado el archivo de promedios con éxito.'
  file.close

end

# generate_file_average(grades)

def count_absent(grades)

  puts ''
  puts 'Iniciando método...'
  grades.each do |student|
    abset_counter = 0
    student_name = student[0]
    for i in 1..(student.length-1) do
        if student[i] == 'A'
          abset_counter += 1
        end
    end
    puts "El alumno #{student_name} tuvo #{abset_counter} inasistencia/s"
  end

  puts ''
  puts 'Método ejecutado con éxito'

end

# count_absent(grades)

def show_aproved(grades, min_grade = 5.0)

  puts ''
  puts 'Iniciando método...'
  puts "El promedio mínimo para aprobar es #{min_grade}"

  grades.each do |student|
    student_name = student[0]
    student_average = (student[1].to_f + student[2].to_f + student[3].to_f + student[4].to_f + student[5].to_f) / 5
    if student_average >= min_grade
      puts "El alumno #{student_name} APRUEBA ya que tiene promedio #{student_average}"
    else
      puts "El alumno #{student_name} NO APRUEBA ya que tiene promedio #{student_average}"
    end
  end

  puts ''
  puts 'Método ejecutado con éxito'

end

# show_aproved(grades)


#------------MENÚ DE OPCIONES------------

grades = read_file('curso.csv')
option = 0

puts ''
puts 'Ingresa un número entero del 1 al 4 según las siguientes opciones:'
puts ''

 while option != 4

  puts 'Opción 1: Para generar un archivo con el nombre de cada alumno y el promedio de sus notas.'
  puts 'Opción 2: Para contar la cantidad de inasistencias totales y mostrarlas pantalla.'
  puts 'Opción 3: Para mostrar los nombres de los alumnos aprobados.'
  puts 'Opción 4: Para terminar el programa.'

  option = gets.chomp

  puts case option
       when '1'
         generate_file_average(grades)
       when '2'
         count_absent(grades)
       when '3'
         puts ''
         puts 'Ingresa 1, 2 o 3 según las siguientes opciones:'
         puts '1: Para usar la nota 5.0 como nota de aprobación'
         puts '2: Para ingresar la nota de aprobación tú'
         puts '3: Para volver al menú anterior'

         option2 = gets.chomp

         puts case option2
              when '1'
                show_aproved(grades, 5.0)
              when '2'
                puts 'Ingresa la nota mínima para aprobar o 0 para volver al menú anterior'
                min_grade = gets.chomp.to_f
                while !(min_grade >= 0 && min_grade <= 10.0) do
                  puts ''
                  puts 'Ingresa correctamente un número entero entre 1 y 3 por favor:'
                  min_grade = gets.chomp.to_f
                end

                if min_grade == 0

                else
                  show_aproved(grades, min_grade)
                end
              when '3'

              else
                puts ''
                puts 'Ingresa correctamente un número entero entre 1 y 3 por favor:'
              end

       when '4'
         break
       else
         puts ''
         puts 'Ingresa correctamente un número entero entre 1 y 4 por favor:'
       end

 end
