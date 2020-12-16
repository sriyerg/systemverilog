MDIR        := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
CDIR        := $(realpath .)
SEED        := $(shell od -vAn -N4 -tu < /dev/random | xargs)
JOB_PREFIX  ?=

# waves
WAVES ?= 1

mode ?= ip
ifeq (${mode},ip)
  TB = foo_tb
else
  TB = top_tb
endif

# export stuff
export VCS_ARCH_OVERRIDE      := linux
export VCS_LIC_EXPIRE_WARNING := 1
export WAVES
export TB

TOOL ?= vcs
ifeq (${TOOL},vcs)
  COMPILE_CMD  =  vlogan
  COMPILE_OPTS+=  -full64 \
                  -sverilog \
                  +incdir+${CDIR} \
                  -timescale=1ns/1ps

  ELAB_CMD     =  vcs
  ELAB_OPTS   +=  -full64 \
                  -sverilog \
                  -licqueue \
                  -timescale=1ns/1ps \
                  -debug_access+all \
                  -o ${CDIR}/simv

  RUN_CMD      =  ${CDIR}/simv
  RUN_OPTS    +=  -licqueue \
                  -ucli -do ${MDIR}/vcs.tcl \
                  +ntb_random_seed=${SEED}

else ifeq (${TOOL},xcelium)
  ELAB_CMD    =  xrun
  ELAB_OPTS   +=  -sv \
                  -64bit \
                  -elaborate \
                  -timescale 1ns/1ps \
                  -access +r \
                   -messages \
                  -errormax 50 \
                   -disable_sem2009 \
                   -f ${CDIR}/run.f \
                   -xmlibdirname ${CDIR}/xcelium.d

  RUN_CMD      =  xrun
  RUN_OPTS    +=  -input ${MDIR}/xcelium.tcl \
                  -64bit -xmlibdirname ${CDIR}/xcelium.d \
                  -R +SVSEED=${SEED} \

else
$(error Unsupported tool: ${TOOL})
endif

UVM ?= 0
ifeq (${UVM},1)
ifeq (${TOOL},vcs)
  COMPILE_OPTS += -ntb_opts uvm-1.2
else ifeq (${TOOL},xcelium)
  ELAB_OPTS += -uvmhome ${UVM_HOME}
endif
COMPILE_OPTS += +define+UVM_REGEX_NO_DPI
RUN_OPTS   += +UVM_VERBOSITY=UVM_HIGH
endif

all: run

compile:
	env > env_vars
	${JOB_PREFIX} ${COMPILE_CMD} ${COMPILE_OPTS} -work ip -f ip_rtl.f
	${JOB_PREFIX} ${COMPILE_CMD} ${COMPILE_OPTS} -work system -f system_rtl.f
	${JOB_PREFIX} ${COMPILE_CMD} ${COMPILE_OPTS} -work foundry -f foundry_rtl.f
	${JOB_PREFIX} ${COMPILE_CMD} ${COMPILE_OPTS} -work dv -f dv.f
	${JOB_PREFIX} ${COMPILE_CMD} ${COMPILE_OPTS} -f work.f

elab_ip: compile
	${JOB_PREFIX} ${ELAB_CMD} ${ELAB_OPTS} -top ip_cfg

elab_system: compile
	${JOB_PREFIX} ${ELAB_CMD} ${ELAB_OPTS} -top system_cfg

elab_foundry: compile
	${JOB_PREFIX} ${ELAB_CMD} ${ELAB_OPTS} -top foundry_cfg

run: elab_${mode}
	${JOB_PREFIX} ${RUN_CMD} ${RUN_OPTS} +mode=${mode}

clean:
	rm -rf ${CDIR}/verdi* ${CDIR}/simv* ${CDIR}/*.fsdb ${CDIR}/ucli* ${CDIR}/csrc \
	${CDIR}/*.d ${CDIR}/*_work ${CDIR}/*.log ${CDIR}/64 ${CDIR}/*.DB \
	${CDIR}/novas* ${CDIR}/env_vars

.PHONY: compile elab_ip elab_system elab_foundry run clean
